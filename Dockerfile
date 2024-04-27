FROM archlinux:latest
RUN pacman -Syu --noconfirm base-devel git xpra xorg xorg-server-xvfb xorg-xauth ffmpeg simutrans simutrans-pak128
USER nobody
RUN git clone https://aur.archlinux.org/simutrans-pak128.japan.git /tmp/simutrans-pak128.japan
RUN git clone https://aur.archlinux.org/simutrans-pak128.german.git /tmp/simutrans-pak128.german

WORKDIR /tmp/simutrans-pak128.japan
RUN makepkg --noconfirm
WORKDIR /tmp/simutrans-pak128.german
RUN makepkg --noconfirm
USER root
WORKDIR /tmp/
RUN pacman -U --needed --noconfirm simutrans-pak128.*/simutrans-pak128.*.pkg.tar.zst
COPY run-server.sh run-server.sh
ENV XPRA_PASSWORD=simutrans
EXPOSE 6000
EXPOSE 13353
CMD [ "run-server.sh" ]