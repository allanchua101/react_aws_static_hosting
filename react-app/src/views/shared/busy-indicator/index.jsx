import React from "react";
import Stack from "@mui/material/Stack";
import Grid from "@mui/material/Grid";
import Box from "@mui/material/Box";
import "./index.scss";

export default function BusyIndicator({ text = "Grab your popcorn..." }) {
  return (
    <Grid item xs={12} className="srv srv--busy-wrap">
      <Stack direction="column" alignItems="center">
        <Box className="srv srv--busy-box">
          <span className="srv srv--loader"></span>
        </Box>
        <p className="srv srv--busy-loader">{text}</p>
      </Stack>
    </Grid>
  );
}
