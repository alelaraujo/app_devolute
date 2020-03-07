import React from 'react'
// import ReactDOM from 'react-dom'
// import PropTypes from 'prop-types'

class AllItems extends React.Component {
    constructor(props) {
      super(props);
      this.listRef = React.createRef();
      this.items = [];
    }
  
    // getInitialState() {
    //     return { items: [] }
    // }

    componentDidMount() {
        $.getJSON('/api/v1/albums.json', (response) => { this.setState({ albums: response }) });
    }

    componentDidMount() {
        console.log("Component mounted");
    }

    render() {
        // const Body = () => {
        // const items = (this.state.items.map(item)
        //     ), return (
        //         <div>
        //             <h3>{item.name}</h3>
        //             <p>{item.description}</p>
        //         </div>
        //     )
        console.log(this.items);
        
    
        return(
            <div>
                // {items}
            </div>
        )
    }
}
export default AllItems