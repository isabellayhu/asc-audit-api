import MainLayout from "../layout/MainLayout";
import Template from "../pages/Template";
import TemplateList from "../pages/TemplateList";

// ==============================|| MAIN ROUTING ||============================== //

const MainRoutes = {
    path: '/',
    element: <MainLayout />,
    children: [
        {
            path: '/',
            element: <TemplateList />
        },
        {
            path: 'new-template',
            element: <Template />
        }
    ]
};

export default MainRoutes;
