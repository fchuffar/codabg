# Codalab/Codabench Bundle Generator (`codabg`)

To create a Codalab competition, you have to generate a zip file with
the required files inside and upload the archive on the Codalab
platform. The *R* script `generate_bundle.Rmd` allows you to
automatically create a valid bundle by using the *R* terminal and `config.R` file.

## Generate a Codalab bundle

In a *R* terminal, run the following command :

```
system("bash clean.sh") ;  
challenge_name="sexpred0.3"; 
rmarkdown::render("01_generate_bundle.Rmd")
```

## Test the Codalab bundle

In a *R* terminal, run the following command :

```
rmarkdown::render("02_test_bundle.Rmd")
```

