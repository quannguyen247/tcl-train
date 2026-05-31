# ==============================================================================
# EXERCISM TCL PRACTICE: BAFFLING-BIRTHDAYS
# ==============================================================================
# # Instructions
#
# Your task is to estimate the birthday paradox's probabilities.
#
# To do this, you need to:
#
# - Generate random birthdates.
# - Check if a collection of randomly generated birthdates contains at least two with the same birthday.
# - Estimate the probability that at least two people in a group share the same birthday for different group sizes.
#
# ~~~~exercism/note
# A birthdate includes the full date of birth (year, month, and day), whereas a birthday refers only to the month and day, which repeat each year.
# Two birthdates with the same month and day correspond to the same birthday.
# ~~~~
#
# ~~~~exercism/caution
# The birthday paradox assumes that:
#
# - There are 365 possible birthdays (no leap years).
# - Each birthday is equally likely (uniform distribution).
#
# Your implementation must follow these assumptions.
# ~~~~

# ==============================================================================
# YOUR SOLUTION CODE BELOW
# ==============================================================================

# Determine if a list of YYYY-MM-DD birthdates contains
# any shared birthdays.

proc sharedBirthday {birthdays} {
    throw {NOT_IMPLEMENTED} "Implement this procedure."
}

# Generate a list of $count random dates in YYYY-MM-DD form.
# Do not include leap years.

proc randomBirthdates {count} {
    throw {NOT_IMPLEMENTED} "Implement this procedure."
}

# Estimate the probability that 2 people in a group of given size
# have the same birthday.

proc estimatedProbabilityOfSharedBirthday {size} {
    throw {NOT_IMPLEMENTED} "Implement this procedure."
}


