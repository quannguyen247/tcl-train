namespace eval grains {
    namespace export square total

    # This turns the namespace name "grains" into
    # the _command_ "grains", with subcommands
    # "square" and "total":
    namespace ensemble create

    proc square {square} {
        return {}
    }

    proc total {} {
        return {}
    }
}

