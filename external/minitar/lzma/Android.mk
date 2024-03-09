LOCAL_PATH := $(TARGET_SRC_DIR)


target_config := $(realpath $(call my-dir))/android-min.h

#BIGFILES := -D_FILE_OFFSET_BITS=64
#liblzma_cflags := -Wall -Winline -O2 -g $(BIGFILES)
liblzma_th_src_files := \
	src/liblzma/common/hardware_cputhreads.c \
	src/liblzma/common/outqueue.c \
	src/liblzma/common/stream_encoder_mt.c

#	src/liblzma/check/crc64_table.c \
#	src/liblzma/check/crc32_table.c \
#	src/liblzma/check/crc32_fast.c \
#	src/liblzma/check/crc64_fast.c \

#	src/liblzma/check/crc64_tablegen.c \
#	src/liblzma/check/crc32_tablegen.c \

#	src/liblzma/lzma/fastpos_table.c \

#	src/liblzma/lzma/fastpos_tablegen.c \

#	src/liblzma/rangecoder/price_tablegen.c \

liblzma_src_files := \
	src/liblzma/rangecoder/price_table.c \
	src/liblzma/lz/lz_decoder.c \
	src/liblzma/lz/lz_encoder_mf.c \
	src/liblzma/lz/lz_encoder.c \
	src/liblzma/common/common.c \
	src/liblzma/common/easy_preset.c \
	src/liblzma/common/stream_buffer_decoder.c \
	src/liblzma/common/hardware_physmem.c \
	src/liblzma/common/index.c \
	src/liblzma/common/block_buffer_decoder.c \
	src/liblzma/common/index_hash.c \
	src/liblzma/common/vli_size.c \
	src/liblzma/common/block_header_decoder.c \
	src/liblzma/common/easy_decoder_memusage.c \
	src/liblzma/common/stream_flags_encoder.c \
	src/liblzma/common/block_buffer_encoder.c \
	src/liblzma/common/filter_buffer_decoder.c \
	src/liblzma/common/stream_flags_common.c \
	src/liblzma/common/index_decoder.c \
	src/liblzma/common/index_encoder.c \
	src/liblzma/common/easy_encoder_memusage.c \
	src/liblzma/common/stream_encoder.c \
	src/liblzma/common/stream_buffer_encoder.c \
	src/liblzma/common/alone_decoder.c \
	src/liblzma/common/easy_encoder.c \
	src/liblzma/common/block_util.c \
	src/liblzma/common/stream_decoder.c \
	src/liblzma/common/auto_decoder.c \
	src/liblzma/common/block_encoder.c \
	src/liblzma/common/filter_common.c \
	src/liblzma/common/filter_flags_encoder.c \
	src/liblzma/common/filter_buffer_encoder.c \
	src/liblzma/common/alone_encoder.c \
	src/liblzma/common/filter_decoder.c \
	src/liblzma/common/stream_flags_decoder.c \
	src/liblzma/common/filter_encoder.c \
	src/liblzma/common/vli_decoder.c \
	src/liblzma/common/filter_flags_decoder.c \
	src/liblzma/common/block_header_encoder.c \
	src/liblzma/common/easy_buffer_encoder.c \
	src/liblzma/common/vli_encoder.c \
	src/liblzma/common/block_decoder.c \
	src/liblzma/lzma/lzma_encoder.c \
	src/liblzma/lzma/lzma_encoder_optimum_fast.c \
	src/liblzma/lzma/lzma_decoder.c \
	src/liblzma/lzma/lzma2_encoder.c \
	src/liblzma/lzma/lzma_encoder_presets.c \
	src/liblzma/lzma/lzma2_decoder.c \
	src/liblzma/lzma/lzma_encoder_optimum_normal.c \
	src/liblzma/check/sha256.c \
	src/liblzma/check/check.c \
	src/liblzma/check/crc32_small.c \
	src/liblzma/check/crc64_small.c \
	src/liblzma/simple/simple_coder.c \
	src/liblzma/simple/armthumb.c \
	src/liblzma/simple/ia64.c \
	src/liblzma/simple/arm.c \
	src/liblzma/simple/x86.c \
	src/liblzma/simple/sparc.c \
	src/liblzma/simple/powerpc.c \
	src/liblzma/simple/simple_encoder.c \
	src/liblzma/simple/simple_decoder.c \
	src/liblzma/delta/delta_common.c \
	src/liblzma/delta/delta_encoder.c \
	src/liblzma/delta/delta_decoder.c

include $(CLEAR_VARS)
LOCAL_MODULE := liblzma
LOCAL_MODULE_TAGS := optional
LOCAL_SRC_FILES := $(liblzma_src_files)
LOCAL_C_INCLUDES := \
	$(LOCAL_PATH)/src/liblzma/api \
	$(LOCAL_PATH)/src/liblzma/common \
	$(LOCAL_PATH)/src/liblzma/check \
	$(LOCAL_PATH)/src/liblzma/lzma \
	$(LOCAL_PATH)/src/liblzma/lz \
	$(LOCAL_PATH)/src/liblzma/simple \
	$(LOCAL_PATH)/src/liblzma/delta \
	$(LOCAL_PATH)/src/liblzma/rangecoder \
	$(LOCAL_PATH)/src/common
LOCAL_CFLAGS := -include $(target_config)
include $(BUILD_STATIC_LIBRARY)
