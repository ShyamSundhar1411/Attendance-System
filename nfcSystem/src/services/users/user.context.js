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
      const response = await axios.get(
        "http://192.168.56.1:3000/get/users/all"
      );
      setUsers(response.data);
      console.log(response.data);
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
