{ pkgs, ... }:

{
  home.packages = with pkgs; [
    (pkgs.st.overrideAttrs (oldAttrs: rec {
      src = ../config/st;
     
      buildInputs = oldAttrs.buildInputs ++ [
   	pkg-config
   	xorg.libX11
   	xorg.libXft
   	xorg.libXinerama
   	fontconfig
  	freetype
   	harfbuzz
   	gcc
   	gnumake
      ];     

      patches = [
        (fetchpatch {
          url = "https://st.suckless.org/patches/scrollback/st-scrollback-ringbuffer-0.9.2.diff";
          sha256 = "1r23q4mi5bkam49ld5c3ccwaa1li7bbjx0ndjgm207p02az9h4cn";
        })
        (fetchpatch {
          url = "https://st.suckless.org/patches/scrollback/st-scrollback-mouse-0.9.2.diff"; 
          sha256 = "068s5rjvvw2174y34i5xxvpw4jvjy58akd1kgf025h1153hmf7jy";
        })
        (fetchpatch {
          url = "https://st.suckless.org/patches/scrollback/st-scrollback-float-0.9.2.diff";
          sha256 = "01r1gdgkcpf9194257myjnr5nn1fj1baj13wjm9rf2nclbagifgm";
        })
        (fetchpatch {
          url = "https://st.suckless.org/patches/alpha/st-alpha-20240814-a0274bc.diff";
          sha256 = "0hld9dwkk7i1f0z0k9biigx2g4wzlqa2yb7vdn5rrf6ymr5nlbsn";
        })
        (fetchpatch {
          url = "https://st.suckless.org/patches/anysize/st-expected-anysize-0.9.diff";
          sha256 = "04gvkf80lhaiwyv3m7fdkf81msf8al1kfb7inx1bf02ygx9152v2";
        })
        (fetchpatch {
          url = "https://st.suckless.org/patches/ligatures/0.9.3/st-ligatures-scrollback-ringbuffer-20251007-0.9.3.diff";
          sha256 = "0c2w1p0siafiyarfx6skdighwzw29d1mydpjfrwgrvdsywwyq2di";
        })
        (fetchpatch {
          url = "https://st.suckless.org/patches/blinking_cursor/st-blinking_cursor-20230819-3a6d6d7.diff";
          sha256 = "0a1agv8wcscpf1kqqsn61a98zidhxyxls1f0vrlj53qplmdyrwqs";
        })
        #(fetchpatch {
        #  url = "https://st.suckless.org/patches/xresources-with-reload-signal/st-xresources-signal-reloading-20220407-ef05519.diff";
        #  sha256 = "1hjb1ssv53cv2lz4p9fbd0xpwvq9f3mdd7l16gxb2kdiyyi4gr49";
        #})
      ];
    }))

   (pkgs.dmenu.overrideAttrs (_: {
     src = ../config/dmenu;
     patches = [ ]; 
   }))

   slock
  ];
}
