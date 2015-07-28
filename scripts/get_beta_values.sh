planemo tool_init --force \
                    --id 'get_beta' \
                    --name 'Get Beta values from RGset of 450k arrays' \
                    --requirement minfi@1.15.7 \
                    --example_command 'Rscript get_beta_values.R --RGset=$RGset --output=$beta_values' \
                    --example_input RGset.RData \
                    --example_output Beta_values.txt \
                    --test_case \
                    --help_from_command " 

		    A ‘MethylSet’ stores ‘meth’ and ‘Unmeth’.  From these it is easy
		    to compute Beta values, defined as

                     Beta = Meth / (Meth + Unmeth + offset)"