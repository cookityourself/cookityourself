module round_all (radius) {
  render() {
    minkowski() {
      children();
      circle (r=radius);
    }
  }
}