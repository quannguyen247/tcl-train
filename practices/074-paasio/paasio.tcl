oo::class create PlatformIO {
    # Your class must contain these methods
    #
    # open   -- to wrap file channels for monitoring file i/o
    # socket -- to wrap network sockets for monitoring network i/o
    # stats  -- to return the statistics as a dictionary
    #
    # Your class instances must also conform to the 
    # channel transform command handler API
    # https://www.tcl-lang.org/man/tcl9.0/TclCmd/transchan.html

    variable counts

    # Initialize metrics to 0
    constructor {} {
        set counts [dict create reads 0 readBytes 0 writes 0 writeBytes 0]
    }

    # Open file and start monitoring
    method open {args} {
        set channel [::open {*}$args]
        ::chan configure $channel -translation {auto lf}
        ::chan push $channel [self]
        return $channel
    }

    # Open network connection and start monitoring
    method socket {args} {
        set channel [::socket {*}$args]
        ::chan push $channel [self]
        return $channel
    }

    # Return the counted metrics
    method stats {} {
        return $counts
    }

    # Initialize read and write operations
    method initialize {handle mode} {
        return [list initialize finalize {*}$mode]
    }

    # No further processing needed when closing channel
    method finalize {handle} {}

    # Increment read count and bytes read
    method read {handle data} {
        dict incr counts reads
        dict incr counts readBytes [string length $data]
        return $data
    }

    # Increment write count and bytes written
    method write {handle data} {
        dict incr counts writes
        dict incr counts writeBytes [string length $data]
        return $data
    }
}
