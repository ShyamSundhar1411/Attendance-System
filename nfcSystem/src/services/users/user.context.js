import React, {
  useState,
  createContext,
  useEffect,
  useMemo,
  useContext,
} from "react";
import axios from "axios";
export const NFCUserContext = createContext();

export const NFCUserContextProvider = ({ children }) => {
  const [users, setUsers] = useState([]);
  const [isLoading, setIsLoading] = useState(false);
  const [error, setError] = useState(null);
  const retrieveUsers = async () => {
    try {
      setIsLoading(true);
      setUsers([]);
      const response = await axios.get("http://127.0.0.1:5000/get/users/all");
      setUsers(response.data);
      setIsLoading(false);
    } catch (err) {
      setError(err);
      console.error("Error Fetching Data:", err);
      setIsLoading(false);
    }
  };
  useEffect(() => {
    retrieveUsers();
  }, []);
  return (
    <NFCUserContext.Provider
      value={{
        users,
        isLoading,
        error,
      }}
    >
      {children}
    </NFCUserContext.Provider>
  );
};
