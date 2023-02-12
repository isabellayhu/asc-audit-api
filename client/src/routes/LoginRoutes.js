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
