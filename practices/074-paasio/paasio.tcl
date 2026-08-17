oo::class create PlatformIO {

    variable counts

    constructor {} {
        set counts [dict create reads 0 readBytes 0 writes 0 writeBytes 0]
    }

    method open {args} {
        set channel [::open {*}$args]
        ::chan configure $channel -translation {auto lf}
        ::chan push $channel [self]
        return $channel
    }

    method socket {args} {
        set channel [::socket {*}$args]
        ::chan push $channel [self]
        return $channel
    }

    method stats {} {
        return $counts
    }

    method initialize {handle mode} {
        return [list initialize finalize {*}$mode]
    }

    method finalize {handle} {}

    method read {handle data} {
        dict incr counts reads
        dict incr counts readBytes [string length $data]
        return $data
    }

    method write {handle data} {
        dict incr counts writes
        dict incr counts writeBytes [string length $data]
        return $data
    }
}
