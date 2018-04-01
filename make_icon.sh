echo "Making icons from: $1"

# 29
sips -z 29 29 "$1" --out "icon-29pt.png"
sips -z 58 58 "$1" --out "icon-29pt@2x.png"
sips -z 87 87 "$1" --out "icon-29pt@3x.png"
# 40
sips -z 40 40 "$1" --out "icon-40pt.png"
sips -z 80 80 "$1" --out "icon-40pt@2x.png"
sips -z 120 120 "$1" --out "icon-40pt@3x.png"
#60
sips -z 60 60 "$1" --out "icon-60pt.png"
sips -z 120 120 "$1" --out "icon-60pt@2x.png"
sips -z 180 180 "$1" --out "icon-60pt@3x.png"
#76
sips -z 76 76 "$1" --out "icon-76pt.png"
sips -z 152 152 "$1" --out "icon-76pt@2x.png"
#83.5
sips -z 167 167 "$1" --out "icon-83.5pt@2x.png"

echo done
