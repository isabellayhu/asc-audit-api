import { Outlet } from 'react-router-dom';

const MinimalLayout = () => (
  <>
    <h1>ASC Audits</h1>
    <Outlet />
  </>
);

export default MinimalLayout;
