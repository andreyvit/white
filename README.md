Fix your whitespace
===================

Run from your project folder before committing to Git to avoid whitespace errors.


Installation
------------

    sudo gem install whitespace


Usage
-----

    cd MyProject
    ...hack hack hack...
    whitespace
    git commit -a -m "Add another awesome feature"


Options
-------

    $ whitespace --help
    Usage: whitespace [options]

    Tab expansion:
        -t, --tabsize=SIZE               Expand tabs using the given tab size

    Picking files to process:
        -e, --ext=EXT                    Include files with the given extension (e.g. -e inc)
        -n, --name=NAME                  Include files with the given name (e.g. -n Cakefile)

    Common options:
        -v, --verbose                    Show a full list of processed files
        -h, --help                       Show this message


License
-------

Copyright (c) 2011 Andrey Tarantsov. MIT license.
