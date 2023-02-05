import './App.css';
import {
  BrowserRouter,
} from "react-router-dom";
import AppRouter from './routes';

function App() {
  return (
    <div className="App">
      {/* <header className="App-header">
        <h1>ASC Audits</h1>
      </header> */}
      <BrowserRouter>
        <AppRouter/>
      </BrowserRouter>
    </div>
  );
};

export default App;
