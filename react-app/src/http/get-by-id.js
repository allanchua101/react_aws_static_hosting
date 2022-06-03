const { REACT_APP_TMDB_API_KEY: API_KEY, REACT_APP_TMDB_API: API_URL } =
  process.env;

export async function getMovie(id) {
  let url = `${API_URL}/movie/${id}?api_key=${API_KEY}`;

  const data = await fetch(url).then((res) => res.json());

  return data;
}
