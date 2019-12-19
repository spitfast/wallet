import React from 'react';
import axios from 'axios';

class TransferForm extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      wallets: null,
      result: '',
      errors: '',
      withdraw_wallet_id: 'select',
      deposit_wallet_id: 'select',
      amount: 0,
    };

    this.handleSelectChange = this.handleSelectChange.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this)
    this.handleAmountChange = this.handleAmountChange.bind(this)
  }

  handleSelectChange({ target }) {
    const wallet = target.getAttribute('id');

    this.setState({ [wallet]: target.value });
  }

  handleAmountChange({ target }) {
    this.setState({ amount: target.value })
  }

  handleSubmit() {
    this.setState({ result: '' });

    if (!this.validParams()) {
      this.setState({ errors: 'Please, select deposit/withdraw wallets and amount', result: false });
      return;
    }

    axios
      .post('/api/v1/transfers', {
        withdraw_wallet_id: this.state.withdraw_wallet_id,
        deposit_wallet_id: this.state.deposit_wallet_id,
        amount: this.state.amount,
      })
      .then(response => this.setState({ result: response.data.success, errors: '' }))
      .catch((error) => {
        this.setState({ result: false, errors: error.response.data.error });
      });
  }

  validParams() {
    return ((this.state.withdraw_wallet_id !== 'select') && (this.state.deposit_wallet_id !== 'select')
              && (parseFloat(this.state.amount) !== 0));
  }

  componentDidMount() {
    axios
      .get('/api/v1/wallets')
      .then(response => this.setState({ wallets: response.data }))
      .catch((response) => {
        console.log(response);
      });
  }

  renderSelectItems() {
    const { wallets } = this.state;

    return wallets.map(wallet => (
      <option value={wallet.id} key={wallet.id}>
        {wallet.name}
      </option>
    ));
  }

  render() {
    const { wallets } = this.state;
    if (wallets === null) return null;

    const showErrors = this.state.errors.length > 0;
    const showSuccess = this.state.result;

    return (
      <div>
        {showErrors &&
          <div className="alert alert-danger">
            {this.state.errors}
          </div>
        }
        {showSuccess &&
          <div className="alert alert-success">Done.</div>
        }
        <div className="row">
          <div className="col">
            <div className="form-group">
              <label>Withdraw wallet</label>
              <select className="form-control" onChange={this.handleSelectChange} id="withdraw_wallet_id" defaultValue={this.state.withdraw_wallet}>
                <option value="select">Select a wallet</option>
                {this.renderSelectItems()}
              </select>
            </div>
          </div>
          <div className="col">
            <div className="form-group">
              <label>Deposit wallet</label>
              <select className="form-control" onChange={this.handleSelectChange} id="deposit_wallet_id" defaultValue={this.state.deposit_wallet}>
                <option value="select">Select a wallet</option>
                {this.renderSelectItems()}
              </select>
            </div>
          </div>
          <div className="col">
            <div className="form-group">
              <label>Amount</label>
              <div className="input-group mb-3">
                <div className="input-group-prepend">
                  <span className="input-group-text" id="amount">Amount</span>
                </div>
                <input type="number" step="any" className="form-control" placeholder="0" defaultValue={this.state.amount} onChange={this.handleAmountChange} />
              </div>
            </div>
          </div>
        </div>
        <div className="row">
          <div className="col">
            <div className="form-group float-right">
              <button type="button" onClick={this.handleSubmit} className="btn btn-primary btn-lg">Transfer</button>
            </div>
          </div>
        </div>
      </div>
    );
  }
}

export default TransferForm;