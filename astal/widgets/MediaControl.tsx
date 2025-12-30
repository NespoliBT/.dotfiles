import Mpris from "gi://AstalMpris";
import { bind, Variable } from "astal";
import { Astal, Gtk } from "astal/gtk3";

const MediaPlayer = ({ player }) => {
  const playState = player.playback_status;
  const title = bind(player, "title").as((t) => t || "Unknown Track");

  const artist = bind(player, "artist").as((a) => a || "Unknown Artist");

  const coverArt = bind(player, "coverArt").as(
    (c) => `background-image: url('${c}')`
  );

  const playerIcon = bind(player, "entry").as((e) =>
    Astal.Icon.lookup_icon(e) ? e : "audio-x-generic-symbolic"
  );

  const position = bind(player, "position").as((p) =>
    player.length > 0 ? p / player.length : 0
  );

  const playIcon = bind(player, "playbackStatus").as((s) =>
    s === Mpris.PlaybackStatus.PLAYING
      ? "media-playback-pause-symbolic"
      : "media-playback-start-symbolic"
  );

  return (
    <box className="mediaPlayer">
      <box className="coverArt" css={bind(coverArt).as((c) => c)}></box>
      <centerbox className="controls" vertical valign={Gtk.Align.CENTER}>
        <button
          className="previous"
          onClicked={() => {
            player.previous();
          }}
          visible={bind(player, "canGoPrevious")}
          valign={Gtk.Align.START}
        >
          <icon icon="media-skip-backward-symbolic" />
        </button>
        <button
          className="playPause"
          valign={Gtk.Align.CENTER}
          onClicked={() => {
            player.play_pause();
          }}
        >
          <icon icon={bind(playIcon)} />
        </button>
        <button
          className="next"
          valign={Gtk.Align.END}
          visible={bind(player, "canGoNext")}
          onClicked={() => {
            player.next();
          }}
        >
          <icon icon="media-skip-forward-symbolic" />
        </button>
      </centerbox>
      <box className="right" vertical>
        <box className="text" vertical={Gtk.Orientation.VERTICAL}>
          <label
            className="title"
            halign={Gtk.Align.START}
            wrap
            maxWidthChars={24}
          >
            {bind(title)}
          </label>
          <label
            className="artist"
            halign={Gtk.Align.START}
            wrap
            maxWidthChars={40}
          >
            {bind(artist)}
          </label>
        </box>
      </box>
    </box>
  );
};

const MediaControl = () => {
  const mpris = Mpris.get_default();

  return (
    <box vertical className="mediaControl">
      {bind(mpris, "players").as((arr) =>
        arr.map((player) => <MediaPlayer player={player} />)
      )}
    </box>
  );
};

export default MediaControl;
