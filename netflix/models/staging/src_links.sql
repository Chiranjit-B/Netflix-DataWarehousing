WITH raw_links AS (
    SELECT *
    FROM MOVIELENS.RAW.LINKS
)
SELECT
    MOVIEID AS movie_id,
    IMDBID AS imdb_id,
    TMDBID AS tmdb_id
FROM raw_links
