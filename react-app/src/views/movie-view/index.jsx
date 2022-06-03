import React, { useEffect, useState } from "react";
import { useParams } from "react-router-dom";
// MUI Components
import Grid from "@mui/material/Grid";
import Chip from "@mui/material/Chip";
import Card from "@mui/material/Card";
import CardMedia from "@mui/material/CardMedia";
import CardContent from "@mui/material/CardContent";
// Custom components
import BusyIndicator from "../shared/busy-indicator";
// Styles
import "./style.scss";
// HTTP
import { getMovie } from "../../http/get-by-id";

function MovieView() {
  const { id } = useParams();
  const [movie, setMovie] = useState(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchMovie = async () => {
      setLoading(true);
      setMovie(null);

      let res = await getMovie(id);

      setMovie(res);
      setLoading(false);
    };

    fetchMovie();
  }, [id]);

  return (
    <Grid
      container
      spacing={2}
      justifyContent="center"
      className="srv srv--movie-view"
    >
      {!loading && movie && (
        <Grid item xs={12} className="srv srv--movie-view-wrap">
          <Card className="srv srv--movie-view-poster" elevation={0}>
            <CardMedia
              component="img"
              image={`${process.env.REACT_APP_TPOSTER_API}/t/p/w1280${movie.backdrop_path}`}
              height="320px"
            />
            <CardContent class="srv srv--movie-card-content">
              <h1 className="srv srv--movie-view-header">{movie.title}</h1>
              <h4 className="srv srv--movie-view-subheader">{movie.tagline}</h4>
              <p className="srv srv--movie-view-desc">{movie.overview}</p>
              <Chip
                label={`Vote AVG: ${movie.vote_average}`}
                color="success"
                className="srv srv--chip "
              />
              <Chip
                label={`Vote Count: ${parseInt(
                  movie.vote_count
                ).toLocaleString()}`}
                className="srv srv--chip "
              />
              <Chip
                label={`Released: ${movie.release_date}`}
                className="srv srv--chip "
              />
            </CardContent>
          </Card>
        </Grid>
      )}
      {loading && <BusyIndicator text="Fetching movie information..." />}
    </Grid>
  );
}

export default MovieView;
