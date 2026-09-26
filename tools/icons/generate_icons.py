"""Draws the app icon and writes every size needed by Android, iOS and the web.

Usage (from the repository root):  python tools/icons/generate_icons.py
The icon is original artwork (mortarboard + check mark); it does not use any
logo of the Universidad de Cuenca.
"""
from __future__ import annotations

import json
from pathlib import Path

from PIL import Image, ImageDraw, ImageFont

ROOT = Path(__file__).resolve().parents[2]
FONT = ROOT / "assets" / "fonts" / "Roboto-Bold.ttf"
TOP, BOTTOM = (47, 99, 184), (24, 57, 122)
GOLD, WHITE = (245, 197, 66), (255, 255, 255)


def draw_icon(size: int = 1024, maskable: bool = False) -> Image.Image:
    s = 1024
    img = Image.new("RGB", (s, s))
    px = img.load()
    for y in range(s):
        t = y / (s - 1)
        color = tuple(round(TOP[i] + (BOTTOM[i] - TOP[i]) * t) for i in range(3))
        for x in range(s):
            px[x, y] = color
    d = ImageDraw.Draw(img)
    # Maskable icons keep the drawing inside the central safe zone (80 %).
    k = 0.78 if maskable else 1.0

    def P(x: float, y: float) -> tuple[float, float]:
        return (512 + (x - 512) * k, 512 + (y - 512) * k)

    # Cap base and board.
    d.rounded_rectangle([P(352, 430), P(672, 610)], radius=70 * k, fill=(222, 232, 250))
    d.polygon([P(512, 190), P(880, 360), P(512, 530), P(144, 360)], fill=WHITE)
    # Tassel.
    d.line([P(512, 360), P(790, 430), P(790, 560)], fill=GOLD, width=round(22 * k), joint="curve")
    d.ellipse([P(760, 540), P(820, 620)], fill=GOLD)
    # Check mark under the cap.
    d.line([P(420, 700), P(490, 770), P(620, 640)], fill=GOLD, width=round(46 * k), joint="curve")
    # Name.
    font = ImageFont.truetype(str(FONT), round(120 * k))
    text = "PEUC"
    w = d.textlength(text, font=font)
    d.text((512 - w / 2, 512 + (800 - 512) * k), text, font=font, fill=WHITE)
    return img.resize((size, size), Image.LANCZOS)


def rounded(img: Image.Image, radius_ratio: float = 0.22) -> Image.Image:
    size = img.size[0]
    mask = Image.new("L", img.size, 0)
    ImageDraw.Draw(mask).rounded_rectangle([0, 0, size - 1, size - 1], radius=round(size * radius_ratio), fill=255)
    out = img.convert("RGBA")
    out.putalpha(mask)
    return out


def main() -> None:
    base = draw_icon(1024)
    maskable = draw_icon(1024, maskable=True)

    for folder, size in {"mdpi": 48, "hdpi": 72, "xhdpi": 96, "xxhdpi": 144, "xxxhdpi": 192}.items():
        rounded(base.resize((size, size), Image.LANCZOS)).save(
            ROOT / "android" / "app" / "src" / "main" / "res" / f"mipmap-{folder}" / "ic_launcher.png"
        )

    icon_set = ROOT / "ios" / "Runner" / "Assets.xcassets" / "AppIcon.appiconset"
    for image in json.loads((icon_set / "Contents.json").read_text())["images"]:
        points = float(image["size"].split("x")[0])
        scale = int(image["scale"].rstrip("x"))
        # iOS applies its own mask and rejects transparency.
        base.resize((round(points * scale),) * 2, Image.LANCZOS).save(icon_set / image["filename"])

    web = ROOT / "web"
    base.resize((192, 192), Image.LANCZOS).save(web / "icons" / "Icon-192.png")
    base.resize((512, 512), Image.LANCZOS).save(web / "icons" / "Icon-512.png")
    maskable.resize((192, 192), Image.LANCZOS).save(web / "icons" / "Icon-maskable-192.png")
    maskable.resize((512, 512), Image.LANCZOS).save(web / "icons" / "Icon-maskable-512.png")
    rounded(base.resize((64, 64), Image.LANCZOS)).save(web / "favicon.png")

    docs = ROOT / "docs" / "img"
    docs.mkdir(parents=True, exist_ok=True)
    rounded(base.resize((256, 256), Image.LANCZOS)).save(docs / "icon.png")


if __name__ == "__main__":
    main()
