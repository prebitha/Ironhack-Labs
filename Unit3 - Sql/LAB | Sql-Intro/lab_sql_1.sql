#Get unique list of film languages under the alias languagerental
SELECT language_id as language , name from language ;

select* from rental ;
# reviewing how many records are returned
SELECT count(return_date) FROM rental ;

select *  from store