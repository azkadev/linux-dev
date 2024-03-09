/*
 *   NO_XZ - Implies NO_XZ_CREATE and NO_XZ_EXTRACT
 *   NO_XZ_CREATE - Suppress xz compression support.
 *   NO_XZ_EXTRACT - Suppress xz auto-detection and decompression.
 *   NO_BZIP2 - Implies NO_BZIP2_CREATE and NO_BZIP2_EXTRACT
 *   NO_BZIP2_CREATE - Suppress bzip2 compression support.
 *   NO_BZIP2_EXTRACT - Suppress bzip2 auto-detection and decompression.
 *   NO_COMPRESS - Implies NO_COMPRESS_CREATE and NO_COMPRESS_EXTRACT
 *   NO_COMPRESS_CREATE - Suppress compress(1) compression support
 *   NO_COMPRESS_EXTRACT - Suppress compress(1) auto-detect and decompression.
 *   NO_CREATE - Suppress all archive creation support.
 *   NO_CPIO_EXTRACT - Suppress auto-detect and dearchiving of cpio archives.
 *   NO_GZIP - Implies NO_GZIP_CREATE and NO_GZIP_EXTRACT
 *   NO_GZIP_CREATE - Suppress gzip compression support.
 *   NO_GZIP_EXTRACT - Suppress gzip auto-detection and decompression.
 *   NO_LOOKUP - Try to avoid getpw/getgr routines, which can be very large
 *   NO_TAR_EXTRACT - Suppress tar extraction
 */

#define NO_COMPRESS
#define NO_CREATE
#define NO_CPIO_EXTRACT
#define NO_LOOKUP
