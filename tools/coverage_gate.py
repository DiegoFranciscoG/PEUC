"""Fails when line coverage of the given folders is below a threshold.

Usage: python tools/coverage_gate.py coverage/lcov.info 70 lib/domain lib/data
"""
import sys
from pathlib import Path


def coverage(lcov: Path, prefixes: list[str]) -> tuple[int, int]:
    found = hit = 0
    current = None
    for line in lcov.read_text(encoding="utf-8").splitlines():
        if line.startswith("SF:"):
            current = line[3:].replace("\\", "/")
        elif line.startswith("LF:") and current and any(p in current for p in prefixes):
            found += int(line[3:])
        elif line.startswith("LH:") and current and any(p in current for p in prefixes):
            hit += int(line[3:])
    return found, hit


def main() -> None:
    lcov, threshold, *prefixes = sys.argv[1:]
    found, hit = coverage(Path(lcov), prefixes)
    percent = 100 * hit / found if found else 0
    print(f"Cobertura de {', '.join(prefixes)}: {percent:.1f} % ({hit}/{found} líneas)")
    if percent < float(threshold):
        sys.exit(f"Cobertura por debajo del {threshold} %")


if __name__ == "__main__":
    main()
