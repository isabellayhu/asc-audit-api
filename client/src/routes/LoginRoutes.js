// import { lazy } from 'react';

// project import
// import Loadable from 'components/Loadable';
// import MinimalLayout from 'layout/MinimalLayout';

// render - login
// const AuthLogin = Loadable(lazy(() => import('pages/SignIn')));
// const AuthRegister = Loadable(lazy(() => import('pages/SignUp')));

import SignUp from '../pages/SignUp';
import SignIn from '../pages/SignIn';
import MinimalLayout from '../layout/MinimalLayout';


// ==============================|| AUTH ROUTING ||============================== //

const LoginRoutes = {
  path: '/',
  element: <MinimalLayout />,
  children: [
    {
      path: 'login',
      element: <SignIn />
    },
    {
      path: 'register',
      element: <SignUp />
    }
  ]
};

export default LoginRoutes;
