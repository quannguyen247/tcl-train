set EARTH_YEAR_SECONDS 31557600.0

set planets {
    Mercury 0.2408467 Venus 0.61519726 Earth 1.0 Mars 1.8808158
    Jupiter 11.862615 Saturn 29.447498 Uranus 84.016846 Neptune 164.79132
}

dict for {planet period} $planets {
    proc on$planet {seconds} "return \[expr {\$seconds / ($EARTH_YEAR_SECONDS * $period)}\]"
}

proc unknown {cmd args} {
    error "not a planet"
}
