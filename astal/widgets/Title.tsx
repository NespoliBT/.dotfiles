import { Astal, Gtk, Gdk, astalify } from "astal/gtk3";

const Title = ({ color, size, maxWidth, child }: Props) => {
  return (
    <label
      className={`color_${color} titleEl`}
      css={`
        font-size: ${size ? size + "px" : "inherit"};
      `}
      valign={Gtk.Align.START}
      halign={Gtk.Align.CENTER}
      maxWidthChars={maxWidth}
      wrap
    >
      {child}
    </label>
  );
};

export default Title;
