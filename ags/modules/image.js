import {
    Box,
} from 'resource:///com/github/Aylur/ags/widget.js';

export const Image = (src, height = 100, width = 100) => {
    return Box({
        className: "image",
        hpack: "center",
        vpack: "center",
        css: `min-width: ${width}px;` +
            `min-height: ${height}px;` +
            `background-image: url('${src}');` +
            "background-size: cover;" +
            "background-position: center;"
    })
};