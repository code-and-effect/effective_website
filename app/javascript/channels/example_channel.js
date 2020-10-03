import consumer from './consumer'

consumer.subscriptions.create('ExampleChannel', {
  connected () {
    this.send({ message: 'Client is live' })
  },

  received (data) {
    console.log(data)
  }
})
