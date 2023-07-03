#! /bin/awk -f
BEGIN {prev_lvl = 0}

# Remove leading spaces in section headings.
{
    $0 = gensub(/^( *)" +/, "\\1\"", 1);
}

# The recipe for level four sections erroneously picks up level 5 and 6 #
# sections. The latter usually include all their text in the heading, so we don't
# want them.
/^ {12}"(I+|(I*VI*))(\.[0-9]+){5} .*$/ { next }

# We'll adjust the level of level 5 headings by adding more indentation.
/^ {12}"(I+|(I*VI*))(\.[0-9]+){4} .*$/ {
    $0 = "    " $0
}

# Calculate heading level based on indentation, four spaces per level.
{
    indent = gensub(/^( *)".*$/,"\\1",1);
    lvl = int(length(indent)/4)+1;
}

#{print "lvl=", lvl, " prev_lvl=", prev_lvl }

# Skip lines that increase the heading level by more than one.
# These are always spurious.
(lvl > prev_lvl+1) { next }

# Finally, print headers that
#
# - are level 1, or
# - start with a normal section number, or
# - start with a partition VI annex section number (they're weird), or
# - are one of a few other exceptions that we make.
#
lvl == 1 \
|| /"(I+|(I*VI*))(\.[0-9]+){1,4} / \
|| /"VI.(Annex|[A-G](.[0-9]+{0,3}))/ \
|| (/"Table of Contents"/ || /"Index"/) {
    print $0; prev_lvl = lvl
}
