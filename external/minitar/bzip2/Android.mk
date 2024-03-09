LOCAL_PATH := $(TARGET_SRC_DIR)

BIGFILES := -D_FILE_OFFSET_BITS=64
libbz2_cflags := -Wall -Winline -O2 -g $(BIGFILES)

libbz2_src_files := \
      blocksort.c \
      huffman.c \
      crctable.c \
      randtable.c \
      compress.c \
      decompress.c \
      bzlib.c

include $(CLEAR_VARS)
LOCAL_MODULE := libbz2
LOCAL_MODULE_TAGS := optional
LOCAL_SRC_FILES := $(libbz2_src_files)
LOCAL_CFLAGS := $(libbz2_cflags)
include $(BUILD_STATIC_LIBRARY)
