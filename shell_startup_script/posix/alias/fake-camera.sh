#! /bin/sh

fake_cam_start() {
    sudo modprobe v4l2loopback card_label="My Fake Webcam" exclusive_caps=1
}

fake_cam_stop() {
    sudo modprobe -r v4l2loopback
}

fake_cam_desktop() {
    ffmpeg -f x11grab -r 16 -s $(cat /sys/class/graphics/fb${1:-0}/virtual_size | tr ',' 'x') -i :0.0+0,0 -vcodec rawvideo -pix_fmt yuv420p -threads 0 -f v4l2 /dev/video4
}

fake_cam_image() {
    ffmpeg -r 0.01 -loop 1 -i "${1}" -vcodec rawvideo -pix_fmt yuv420p -f v4l2 /dev/video4
}

fake_cam_video() {
    ffmpeg -stream_loop -1 -re -i "${1}" -vcodec rawvideo -f v4l2 /dev/video4
}

