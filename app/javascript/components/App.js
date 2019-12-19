import React from 'react';
import TransferForm from './TransferForm';

const App = () => (
  <div>
    <nav className="navbar navbar-dark bg-dark">
      <a className="navbar-brand" href="#">External wallet</a>
    </nav>

    <div className="container">
      <main>
        <div className="jumbotron">
          <TransferForm />
        </div>
      </main>
    </div>
  </div>
);

export default App;