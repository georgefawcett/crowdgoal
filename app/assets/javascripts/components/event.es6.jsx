class Event extends React.Component {

  constructor(props) {
    super(props);
    this.state = {
      id: props.event.id,
      joined_count: props.joined_count
    }
  }

  updateCount(){
    this.setState({joined_count: 100});
  }

  render () {
    return(
      <div className="col s12 m7" style={{width: "100%"}}>
        <div className="card horizontal" style={{border: "1px solid #e3f2fd"}}>
          <div className="card-stacked">
            <div className="card-content small" style={{paddingTop: "8px", paddingBottom: "0"}}>
              <div style={{float:"right"}}>
                <img src={'https://www.linkedin.com/mpr/mpr/AAEAAQAAAAAAAAt2AAAAJGUyM2NlYjgxLTIxYWMtNDJkMi04NDQyLWI4YzQ1MTJhNjA4OA.jpg'} style={{marginTop: "7px", borderRadius: "50%", border: "1px solid #666666"}} width = "50" />
              </div>
            </div>
          </div>
        </div>
      </div>
  )}
}

