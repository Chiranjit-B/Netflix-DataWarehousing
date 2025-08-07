WITH raw_genome_scores AS (
    SELECT *
    FROM MOVIELENS.RAW.GENOME_SCORES
)
SELECT
    movieId AS movie_id,
    tagId AS tag_id,
    relevance
FROM raw_genome_scores
