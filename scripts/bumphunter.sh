planemo tool_init --force \
                    --id 'bumphunter' \
                    --name 'Get differentially methylated regions' \
                    --requirement minfi@1.15.7 \
                    --example_command 'Rscript bump_hunter.R --RGset=$RGset --design=$design --cutoff=$cutoff --output=$bumps' \
                    --example_input RGset.RData \
                    --example_output bumps.txt \
                    --test_case \
                    --help_from_command "

** What it does**
Estimate regions for which a genomic profile deviates from its
baseline value. Originally implemented to detect differentially
methylated genomic regions between two populations.

Reference:

Jaffe AE, Murakami P, Lee H, Leek JT, Fallin MD, Feinberg AP,
Irizarry RA (2012) Bump hunting to identify differentially
methylated regions in epigenetic epidemiology studies.
International Journal of Epidemiology 41(1):200-9.
"