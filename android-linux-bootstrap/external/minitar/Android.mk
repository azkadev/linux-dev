#
# Copyright (C) 2014 Trevor Drake
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
#


# A bit of a non-standard LOCAL_PATH declaration here
# The Android.mk lives below the top source directory
# but LOCAL_PATH needs to point to the top of the module
# source tree to maintain the integrity of the intermediates
# directories
LOCAL_PATH := $(TARGET_SRC_DIR)


libarchive_target_config := $(realpath $(call my-dir))/android-min.h

libarchive_src_files := libarchive/archive_acl.c \
						libarchive/archive_blake2s_ref.c \
						libarchive/archive_blake2sp_ref.c \
						libarchive/archive_check_magic.c \
						libarchive/archive_cmdline.c \
						libarchive/archive_cryptor.c \
						libarchive/archive_digest.c \
						libarchive/archive_entry.c \
						libarchive/archive_entry_copy_stat.c \
						libarchive/archive_entry_link_resolver.c \
						libarchive/archive_entry_sparse.c \
						libarchive/archive_entry_stat.c \
						libarchive/archive_entry_strmode.c \
						libarchive/archive_entry_xattr.c \
						libarchive/archive_getdate.c \
						libarchive/archive_hmac.c \
						libarchive/archive_match.c \
						libarchive/archive_options.c \
						libarchive/archive_pack_dev.c \
						libarchive/archive_pathmatch.c \
						libarchive/archive_ppmd8.c \
						libarchive/archive_ppmd7.c \
						libarchive/archive_random.c \
						libarchive/archive_rb.c \
						libarchive/archive_read.c \
						libarchive/archive_read_add_passphrase.c \
						libarchive/archive_read_append_filter.c \
						libarchive/archive_read_data_into_fd.c \
						libarchive/archive_read_disk_entry_from_file.c \
						libarchive/archive_read_disk_posix.c \
						libarchive/archive_read_disk_set_standard_lookup.c \
						libarchive/archive_read_extract.c \
						libarchive/archive_read_extract2.c \
						libarchive/archive_read_open_fd.c \
						libarchive/archive_read_open_file.c \
						libarchive/archive_read_open_filename.c \
						libarchive/archive_read_open_memory.c \
						libarchive/archive_read_set_format.c \
						libarchive/archive_read_set_options.c \
						libarchive/archive_read_support_filter_all.c \
						libarchive/archive_read_support_filter_bzip2.c \
						libarchive/archive_read_support_filter_by_code.c \
						libarchive/archive_read_support_filter_compress.c \
						libarchive/archive_read_support_filter_gzip.c \
						libarchive/archive_read_support_filter_grzip.c \
						libarchive/archive_read_support_filter_lrzip.c \
						libarchive/archive_read_support_filter_lz4.c \
						libarchive/archive_read_support_filter_lzop.c \
						libarchive/archive_read_support_filter_none.c \
						libarchive/archive_read_support_filter_program.c \
						libarchive/archive_read_support_filter_rpm.c \
						libarchive/archive_read_support_filter_uu.c \
						libarchive/archive_read_support_filter_xz.c \
						libarchive/archive_read_support_filter_zstd.c \
						libarchive/archive_read_support_format_7zip.c \
						libarchive/archive_read_support_format_all.c \
						libarchive/archive_read_support_format_ar.c \
						libarchive/archive_read_support_format_by_code.c \
						libarchive/archive_read_support_format_cab.c \
						libarchive/archive_read_support_format_cpio.c \
						libarchive/archive_read_support_format_empty.c \
						libarchive/archive_read_support_format_iso9660.c \
						libarchive/archive_read_support_format_lha.c \
						libarchive/archive_read_support_format_mtree.c \
						libarchive/archive_read_support_format_rar.c \
						libarchive/archive_read_support_format_rar5.c \
						libarchive/archive_read_support_format_raw.c \
						libarchive/archive_read_support_format_tar.c \
						libarchive/archive_read_support_format_warc.c \
						libarchive/archive_read_support_format_xar.c \
						libarchive/archive_read_support_format_zip.c \
						libarchive/archive_string.c \
						libarchive/archive_string_sprintf.c \
						libarchive/archive_util.c \
						libarchive/archive_version_details.c \
						libarchive/archive_virtual.c \
						libarchive/archive_write.c \
						libarchive/archive_write_disk_posix.c \
						libarchive/archive_write_disk_set_standard_lookup.c \
						libarchive/archive_write_open_fd.c \
						libarchive/archive_write_open_file.c \
						libarchive/archive_write_open_filename.c \
						libarchive/archive_write_open_memory.c \
						libarchive/archive_write_add_filter.c \
						libarchive/archive_write_add_filter_b64encode.c \
						libarchive/archive_write_add_filter_by_name.c \
						libarchive/archive_write_add_filter_bzip2.c \
						libarchive/archive_write_add_filter_compress.c \
						libarchive/archive_write_add_filter_grzip.c \
						libarchive/archive_write_add_filter_gzip.c \
						libarchive/archive_write_add_filter_lrzip.c \
						libarchive/archive_write_add_filter_lz4.c \
						libarchive/archive_write_add_filter_lzop.c \
						libarchive/archive_write_add_filter_none.c \
						libarchive/archive_write_add_filter_program.c \
						libarchive/archive_write_add_filter_uuencode.c \
						libarchive/archive_write_add_filter_xz.c \
						libarchive/archive_write_add_filter_zstd.c \
						libarchive/archive_write_set_format.c \
						libarchive/archive_write_set_format_7zip.c \
						libarchive/archive_write_set_format_ar.c \
						libarchive/archive_write_set_format_by_name.c \
						libarchive/archive_write_set_format_cpio.c \
						libarchive/archive_write_set_format_cpio_newc.c \
						libarchive/archive_write_set_format_filter_by_ext.c \
						libarchive/archive_write_set_format_gnutar.c \
						libarchive/archive_write_set_format_iso9660.c \
						libarchive/archive_write_set_format_mtree.c \
						libarchive/archive_write_set_format_pax.c \
						libarchive/archive_write_set_format_raw.c \
						libarchive/archive_write_set_format_shar.c \
						libarchive/archive_write_set_format_ustar.c \
						libarchive/archive_write_set_format_v7tar.c \
						libarchive/archive_write_set_format_warc.c \
						libarchive/archive_write_set_format_xar.c \
						libarchive/archive_write_set_format_zip.c \
						libarchive/archive_write_set_options.c \
						libarchive/archive_write_set_passphrase.c \
						libarchive/filter_fork_posix.c \
						libarchive/xxhash.c

libarchive_fe_src_files :=  libarchive_fe/err.c \
							libarchive_fe/line_reader.c \
							libarchive_fe/passphrase.c


minitar_src_files := ../../minitar/minitar.c


minitar_config := $(call my-dir)/minitar-config.h


include $(CLEAR_VARS)
LOCAL_MODULE := libbz2
LOCAL_SRC_FILES := $(realpath $(TARGET_SRC_DIR)/../../bzip2/build/obj/local/$(TARGET_ARCH_ABI)/libbz2.a)
LOCAL_EXPORT_C_INCLUDES := $(realpath $(TARGET_SRC_DIR)/../../bzip2/build/include)
include $(PREBUILT_STATIC_LIBRARY)


include $(CLEAR_VARS)
LOCAL_MODULE := liblzma
LOCAL_SRC_FILES := $(realpath $(TARGET_SRC_DIR)/../../lzma/build/obj/local/$(TARGET_ARCH_ABI)/liblzma.a)
LOCAL_EXPORT_C_INCLUDES := $(realpath $(TARGET_SRC_DIR)/../../lzma/build/include)
include $(PREBUILT_STATIC_LIBRARY)


include $(CLEAR_VARS)
LOCAL_MODULE := libarchive
LOCAL_MODULE_TAGS := optional
LOCAL_SRC_FILES := $(libarchive_src_files)
LOCAL_CFLAGS := -DPLATFORM_CONFIG_H=\"$(libarchive_target_config)\"
LOCAL_C_INCLUDES := $(LOCAL_PATH)/contrib/android/include
LOCAL_EXPORT_C_INCLUDE_DIRS := $(LOCAL_PATH)/libarchive
LOCAL_STATIC_LIBRARIES := libbz2 liblzma
include $(BUILD_STATIC_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE := libarchive_fe
LOCAL_MODULE_TAGS := optional
LOCAL_CFLAGS := -DPLATFORM_CONFIG_H=\"$(libarchive_target_config)\"
LOCAL_SRC_FILES := $(libarchive_fe_src_files)
LOCAL_C_INCLUDES := $(LOCAL_PATH)/contrib/android/include
LOCAL_EXPORT_C_INCLUDE_DIRS := $(LOCAL_PATH)/libarchive_fe
include $(BUILD_STATIC_LIBRARY)


include $(CLEAR_VARS)
LOCAL_MODULE := minitar
LOCAL_MODULE_TAGS := optional
LOCAL_CFLAGS :=  -DBSDTAR_VERSION_STRING=ARCHIVE_VERSION_ONLY_STRING -DPLATFORM_CONFIG_H=\"$(libarchive_target_config)\" -include $(minitar_config)
LOCAL_LDLIBS := -lz
LOCAL_STATIC_LIBRARIES := libarchive libarchive_fe libbz2 liblzma
LOCAL_SRC_FILES := $(minitar_src_files)
LOCAL_C_INCLUDES := $(LOCAL_PATH)/libarchive $(LOCAL_PATH)/libarchive_fe $(LOCAL_PATH)/contrib/android/include
include $(BUILD_EXECUTABLE)
