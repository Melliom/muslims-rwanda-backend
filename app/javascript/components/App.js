import React from 'react';
import { BrowserRouter as Router, Switch, Route } from 'react-router-dom';
import { Provider } from 'react-redux';
import HelloWorld from './HelloWorld';
import Button from './button';
import store from '../store';

const App = () => {
  return (
    <Provider store={store}>
      <Router>
        <Switch>
          <Route exact path="/" component={Button} />
          <Route exact path="/try" component={HelloWorld} />
          <Route exact path="/invite-admin" component={HelloWorld} />
        </Switch>
      </Router>
    </Provider>
  );
};

export default App;
