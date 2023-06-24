import React, {
  useState,
  createContext,
  useEffect,
  useMemo,
  useContext,
} from "react";

export const NFCUserContext = createContext();

export const NFCUserContextProvider = ({ children }) => {
  const [users, setUsers] = useState([]);
  const [isLoading, setIsLoading] = useState(false);
  const [error, setError] = useState(null);
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
