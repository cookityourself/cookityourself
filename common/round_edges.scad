module round_all (radius) {
  render() {
    minkowski() {
      children();
      circle (r=radius);
    }
  }
}

module round_all_3d (radius) {
  render () {
    minkowski () {
      children ();
      sphere (radius);
    }
  }
}

