import consumer from "./consumer"
consumer.subscriptions.create({ channel: "MyFirstChannel" ,room: "room" }, {connected(){console.log("Connected to Websocket")},
    received(data){
    console.log(data)
    if(window.location.pathname === "/play"){
      location = window.location}
    
}})