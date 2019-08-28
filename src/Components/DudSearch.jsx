import React from 'react';

class DudSearch extends React.Component {

  constructor(props) {
    super(props);

    this.state = {
      text: this.props.text
    }
  }

  onChange(e) {
    if (this.props.onChange != null) {
      var val = e.target.value;
      UniversalDashboard.publish('element-event', {
        type: "clientEvent",
        eventId: this.props.id + 'onChange',
        eventName: 'onChange',
        eventData: val
      });
    }
    this.setState({ text: e.target.value });
  }

  onKeyDown(e) {
    if (e.keyCode == 13) {
      if (this.props.onEnter != null) {
        var val = e.target.value;
        UniversalDashboard.publish('element-event', {
          type: "clientEvent",
          eventId: this.props.id + 'onEnter',
          eventName: 'onEnter',
          eventData: val
        });
      }
    }

  }

  render() {
    return <div>
      <input type="text" id={this.props.id}
        defaultValue={this.props.text} value={this.state.text} placeholder={this.props.placeholder}
        onChange={this.onChange.bind(this)} onKeyDown={this.onKeyDown.bind(this)} />
    </div>
  }
}

export default DudSearch
