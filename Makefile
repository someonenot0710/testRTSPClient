all: testRTSPClient
LIBS =  -lGL -lGLU -lX11 -lXxf86vm -lXrandr -pthread -lXi  -lrt  -lvdpau -lva -lva-drm -lva-x11  -lfdk-aac -lmp3lame -lx264 -lavformat -lavcodec -lxcb-shm -lxcb-xfixes -lxcb-render -lxcb-shape -lxcb -lXau -lXdmcp  -lSDL -lasound -ldl -lpulse-simple -lpulse -lXext -lcaca  -llzma -lavutil -lx264 -lfaac -lm -lz -lpthread -ldl -lvorbis -lswscale
# use pkg-config for getting CFLAGS and LDLIBS

FFMPEG_LIBS=    libavdevice                        \
                libavformat                        \
                libavfilter                        \
                libavcodec                         \
                libswresample                      \
                libswscale                         \
                libavutil                          \



CFLAGS += -Wall -g
CFLAGS := $(shell pkg-config --cflags $(FFMPEG_LIBS)) $(CFLAGS)
LDLIBS := $(shell pkg-config --libs $(FFMPEG_LIBS)) $(LDLIBS)



testRTSPClient: testRTSPClient.cpp
	g++ -c -I/home/jerry/ffmpeg_build/include -I../UsageEnvironment/include -I../groupsock/include -I../liveMedia/include -I../BasicUsageEnvironment/include -I. -O3 -DSOCKLEN_T=socklen_t -D_LARGEFILE_SOURCE=1 -D_FILE_OFFSET_BITS=64 -Wall -DBSD=1 -D__STDC_CONSTANT_MACROS testRTSPClient.cpp $(CFLAGS)
	g++ testRTSPClient.o -o testRTSPClient  -I/home/jerry/ffmpeg_build/include ../liveMedia/libliveMedia.a ../groupsock/libgroupsock.a ../BasicUsageEnvironment/libBasicUsageEnvironment.a ../UsageEnvironment/libUsageEnvironment.a  -D__STDC_CONSTANT_MACROS $(LDLIBS) $(LIBS)
clean: 
	rm -f testRTSPClient.o testRTSPClient 
