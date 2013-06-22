LOCAL_PATH:= $(call my-dir)

#
# libmediaplayerservice
#

include $(CLEAR_VARS)

LOCAL_SRC_FILES:=               \
    ActivityManager.cpp         \
    Crypto.cpp                  \
    HDCP.cpp                    \
    MediaPlayerFactory.cpp      \
    MediaPlayerService.cpp      \
    MediaRecorderClient.cpp     \
    MetadataRetrieverClient.cpp \
    MidiFile.cpp                \
    MidiMetadataRetriever.cpp   \
    RemoteDisplay.cpp           \
    StagefrightPlayer.cpp       \
    StagefrightRecorder.cpp     \
    TestPlayerStub.cpp
    
ifeq ($(BUILD_WITH_AMLOGIC_PLAYER),true)
LOCAL_SRC_FILES +=               \
    AmlPlayerMetadataRetriever.cpp
endif

ifeq ($(BUILD_WITH_AMLOGIC_PLAYER),true)
    LOCAL_SRC_FILES +=AmSuperPlayer.cpp
    LOCAL_SRC_FILES +=AmlogicPlayer.cpp
    LOCAL_SRC_FILES +=AmlogicPlayerRender.cpp
    LOCAL_SRC_FILES +=AmlogicPlayerStreamSource.cpp
    LOCAL_SRC_FILES +=AmlogicPlayerStreamSourceListener.cpp
    LOCAL_SRC_FILES +=AmlogicPlayerExtractorDemux.cpp
    LOCAL_SRC_FILES +=AmlogicPlayerExtractorDataSource.cpp
    LOCAL_SRC_FILES +=AmlogicPlayerDataSouceProtocol.cpp
endif

LOCAL_SHARED_LIBRARIES :=       \
    libbinder                   \
    libcamera_client            \
    libcutils                   \
    libdl                       \
    libgui                      \
    libmedia                    \
    libmedia_native             \
    libsonivox                  \
    libstagefright              \
    libstagefright_foundation   \
    libstagefright_omx          \
    libstagefright_wfd          \
    libutils                    \
    libdl                       \
    libvorbisidec               \

LOCAL_STATIC_LIBRARIES :=       \
    libstagefright_nuplayer     \
    libstagefright_rtsp         \
    libmedia_helper             \

LOCAL_C_INCLUDES :=                                                 \
    $(call include-path-for, graphics corecg)                       \
    $(TOP)/frameworks/av/media/libstagefright/include               \
    $(TOP)/frameworks/av/include/media                              \
    $(TOP)/frameworks/av/media/libstagefright/rtsp                  \
    $(TOP)/frameworks/av/media/libstagefright/wifi-display          \
    $(TOP)/frameworks/native/include/media/openmax                  \
    $(TOP)/external/tremolo/Tremolo

ifeq ($(BUILD_WITH_AMLOGIC_PLAYER),true)
AMPLAYER_APK_DIR=$(TOP)/packages/amlogic/LibPlayer/
LOCAL_C_INCLUDES +=\
        $(AMPLAYER_APK_DIR)/amplayer/player/include     \
        $(AMPLAYER_APK_DIR)/amplayer/control/include    \
        $(AMPLAYER_APK_DIR)/amadec/include      \
        $(AMPLAYER_APK_DIR)/amcodec/include     \
        $(AMPLAYER_APK_DIR)/amavutils/include     \
        $(AMPLAYER_APK_DIR)/amffmpeg/

LOCAL_SHARED_LIBRARIES += libui
LOCAL_SHARED_LIBRARIES +=libamplayer libamavutils
LOCAL_CFLAGS += -DBUILD_WITH_AMLOGIC_PLAYER=1
endif

ifeq ($(BOARD_USES_QCOM_HARDWARE),true)
LOCAL_C_INCLUDES += \
    $(TOP)/hardware/qcom/media/mm-core/inc
endif

LOCAL_MODULE:= libmediaplayerservice

include $(BUILD_SHARED_LIBRARY)

include $(call all-makefiles-under,$(LOCAL_PATH))
