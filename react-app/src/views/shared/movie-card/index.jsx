import * as React from "react";
import { useNavigate } from "react-router-dom";
// material code
import Grid from "@mui/material/Grid";
import Card from "@mui/material/Card";
import Fade from "@mui/material/Fade";
import CardActionArea from "@mui/material/CardActionArea";
import "./style.scss";

function MovieCard({ movie, index = 1 }) {
  const navigate = useNavigate();

  return (
    <Grid item key={movie.id}>
      <Fade in style={{ transitionDelay: `${index * 30}ms` }}>
        <Card elevation={0} className="srv srv--movie-card" sx={{ mt: 2 }}>
          <CardActionArea>
            <img
              src={movie.posterUrl}
              alt="Poster"
              className="srv srv--poster"
              onClick={() =>
                setTimeout(() => {
                  navigate(`/movie-view/${movie.id}`);
                }, 250)
              }
            />
          </CardActionArea>
        </Card>
      </Fade>
    </Grid>
  );
}

export default MovieCard;
