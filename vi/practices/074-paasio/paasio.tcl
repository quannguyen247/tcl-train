# ==============================================================================
# EXERCISM TCL PRACTICE: PAASIO
# ==============================================================================
# # Instructions
#
# Report network IO statistics.
#
# You are writing a [PaaS][paas], and you need a way to bill customers based on network and filesystem usage.
#
# Create a wrapper for network connections and files that can report IO statistics.
# The wrapper must report:
#
# - The total number of bytes read/written.
# - The total number of read/write operations.
#
# [paas]: https://en.wikipedia.org/wiki/Platform_as_a_service

# ==============================================================================
# YOUR SOLUTION CODE BELOW
# ==============================================================================

oo::class create PlatformIO {
    variable counts

    # Đặt các số liệu ban đầu về 0
    constructor {} {
        set counts [dict create reads 0 readBytes 0 writes 0 writeBytes 0]
    }

    # Mở file và bắt đầu theo dõi
    method open {args} {
        set channel [::open {*}$args]
        ::chan push $channel [self]
        return $channel
    }

    # Mở kết nối mạng và bắt đầu theo dõi
    method socket {args} {
        set channel [::socket {*}$args]
        ::chan push $channel [self]
        return $channel
    }

    # Lấy các số liệu đã đếm
    method stats {} {
        return $counts
    }

    # Chuẩn bị theo dõi việc đọc và ghi
    method initialize {handle mode} {
        return [list initialize finalize {*}$mode]
    }

    # Không cần xử lý thêm khi đóng channel
    method finalize {handle} {}

    # Cộng số lần đọc và số byte đọc
    method read {handle data} {
        dict incr counts reads
        dict incr counts readBytes [string length $data]
        return $data
    }

    # Cộng số lần ghi và số byte ghi
    method write {handle data} {
        dict incr counts writes
        dict incr counts writeBytes [string length $data]
        return $data
    }
}

