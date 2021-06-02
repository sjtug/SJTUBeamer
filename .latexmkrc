# Latexmk configuration file.

# Set environment variables.

# Set timezone.
$ENV{'TZ'}='Asia/Shanghai';

$postscript_mode = $dvi_mode = 0;

# Always try to embed fonts, ignoring licensing flags, etc.
$xdvipdfmx = 'xdvipdfmx -E -o %D %O %S';

# Files to clean.
$clean_ext = 'bbl glo gls hd loa run.xml thm xdv';
