echo "Downsampling retina images..."

dir=$(pwd)
find "$dir" -name "*@3x.png" | while read image; do

    outfile2x=$(dirname "$image")/$(basename "$image" @3x.png)"@2x".png
    outfile=$(dirname "$image")/$(basename "$image" @3x.png).png

    if [ "$image" -nt "$outfile" ]; then
        basename "$outfile"

        width=$(sips -g "pixelWidth" "$image" | awk 'FNR>1 {print $2}')
        height=$(sips -g "pixelHeight" "$image" | awk 'FNR>1 {print $2}')

        sips -z $(($height / 3 * 2)) $(($width / 3 * 2)) "$image" --out "$outfile2x"
        test "$outfile2x" -nt "$image" || exit 1

        sips -z $(($height / 3)) $(($width / 3)) "$image" --out "$outfile"
        test "$outfile" -nt "$image" || exit 1
    fi
done
