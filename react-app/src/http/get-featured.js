const {
  REACT_APP_TMDB_API_KEY: API_KEY,
  REACT_APP_TMDB_API: API_URL,
  REACT_APP_TPOSTER_API: POSTER_URL,
} = process.env;

export async function getFeatured(page = 1) {
  const url = `${API_URL}/discover/movie?sort_by=popularity.desc&api_key=${API_KEY}&page=${page}`;
  const data = await fetch(url).then((res) => res.json());

  return {
    ...data,
    movies: data.results
      .map((m) => {
        return {
          id: m.id,
          title: m.title,
          year: m.release_date ? m.release_date.split("-")[0] : "N/A",
          posterUrl: m.poster_path
            ? `${POSTER_URL}/t/p/w1280/${m.poster_path}`
            : null,
          backDropUrl: m.backdrop_path
            ? `${POSTER_URL}/t/p/w1280/${m.backdrop_path}`
            : null,
        };
      })
      .filter((m) => m.posterUrl),
  };
}
