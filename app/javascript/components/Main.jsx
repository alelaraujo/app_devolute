import React from 'react'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'

import Header from './header'
import Body from './body'

const Main = props => {
  return (
    <div>
      <Header />
      <Body />
    </div>
  )
}

export default Main
