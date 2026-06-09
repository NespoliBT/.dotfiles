"""Convert the current caelestia colour scheme to pywal's colors.json format.
Called by caelestia's postHook with SCHEME_COLOURS set in the environment.
Colors are mapped from Material You semantic roles to match the rest of the desktop."""
import json
import os
import subprocess

raw = os.environ.get("SCHEME_COLOURS")
if raw:
    c = json.loads(raw)
else:
    data = json.loads(subprocess.check_output(["caelestia", "wallpaper", "--print"]))
    c = data["colours"]

def h(key):
    return "#" + c[key]

wal = {
    "wallpaper": "caelestia",
    "alpha": "100",
    "special": {
        "background": h("base"),
        "foreground": h("onSurface"),
        "cursor":     h("primary"),
    },
    "colors": {
        # Dark backgrounds (surface hierarchy)
        "color0":  h("base"),
        "color8":  h("surfaceContainerHigh"),
        # Accents
        "color1":  h("error"),
        "color9":  h("errorDim"),
        "color2":  h("primary"),
        "color10": h("onPrimaryContainer"),
        "color3":  h("tertiary"),
        "color11": h("onTertiaryContainer"),
        "color4":  h("secondary"),
        "color12": h("onSecondaryContainer"),
        "color5":  h("primaryDim"),
        "color13": h("primaryFixed"),
        "color6":  h("secondaryDim"),
        "color14": h("tertiaryFixed"),
        # Foregrounds
        "color7":  h("onSurface"),
        "color15": h("onBackground"),
    },
}

out = os.path.expanduser("~/.cache/wal/colors.json")
os.makedirs(os.path.dirname(out), exist_ok=True)
with open(out, "w") as f:
    json.dump(wal, f, indent=4)

subprocess.run(["pywalfox", "update"], stderr=subprocess.DEVNULL)
